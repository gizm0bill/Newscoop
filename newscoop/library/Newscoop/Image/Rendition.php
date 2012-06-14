<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Image;

use Nette\Image as NetteImage;

require_once __DIR__ . '/../../Nette/exceptions.php';

/**
 * Rendition
 * @Entity
 * @Table(name="rendition")
 */
class Rendition
{
    /**
     * @Id
     * @Column(type="string")
     * @var string
     */
    private $name;

    /**
     * @Column(type="integer")
     * @var int
     */
    private $width;

    /**
     * @Column(type="integer")
     * @var int
     */
    private $height;

    /**
     * @Column
     * @var string
     */
    private $specs;

    /**
     * @var string
     */
    private $coords;

    /**
     * @Column(type="integer", nullable=True)
     * @var int
     */
    private $offset;

    /**
     * @Column(nullable=True)
     * @var string
     */
    private $label;

    /**
     * @param int $width
     * @param int $height
     * @param string $specs
     * @param string $name
     */
    public function __construct($width, $height, $specs = 'fit', $name = null)
    {
        $this->width = (int) $width;
        $this->height = (int) $height;
        $this->specs = (string) $specs;
        $this->name = (string) $name;
    }

    /**
     * @return string
     */
    public function __toString()
    {
        return $this->getName();
    }

    /**
     * Get width
     *
     * @return void
     */
    public function getWidth()
    {
        return $this->width;
    }

    /**
     * Get height
     *
     * @return int
     */
    public function getHeight()
    {
        return $this->height;
    }

    /**
     * Get specification
     *
     * @return string
     */
    public function getSpecs()
    {
        return $this->coords !== null && $this->isCrop() ? 'crop_' . $this->coords :  $this->specs;
    }

    /**
     * Get name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set coordinates for image
     *
     * @param string $coords
     * @return void
     */
    public function setCoords($coords)
    {
        $this->coords = $coords;
    }

    /**
     * Get preview
     *
     * @param int $width
     * @param int $height
     * @return Newscoop\Image\Rendition
     */
    public function getPreview($width, $height)
    {
        list($width, $height) = NetteImage::calculateSize($this->width, $this->height, $width, $height);
        return new Rendition($width, $height, $this->getSpecs());
    }

    /**
     * Get thumbnail
     *
     * @param Newscoop\Image\ImageInterface $image
     * @param Newscoop\Image\ImageService $imageService
     * @return Newscoop\Image\Thumbnail
     */
    public function getThumbnail(ImageInterface $image, ImageService $imageService)
    {
        if (!$this->fits($image)) {
            throw new \InvalidArgumentException("Image is too small.");
        }

        list($width, $height) = NetteImage::calculateSize($image->getWidth(), $image->getHeight(), $this->width, $this->height, $this->getFlags());
        if ($this->isCrop()) {
            $width = min($width, $this->width);
            $height = min($height, $this->height);
        }

        return new Thumbnail($imageService->getSrc($image->getPath(), $this->width, $this->height, $this->getSpecs()), $width, $height);
    }

    /**
     * Generate image
     *
     * @param string $imagePath
     * @return Nette\Image
     */
    public function generateImage($imagePath)
    {
        $path = is_file(APPLICATION_PATH . '/../' . $imagePath) ? APPLICATION_PATH . '/../' . $imagePath : $imagePath;
        $image = NetteImage::fromFile($path);
        if ($this->isCrop()) {
            $cropSpecs = explode('_', $this->getSpecs());
            if (count($cropSpecs) === 1) {
                $image->resize($this->width, $this->height, $this->getFlags());
                $image->crop('50%', '50%', $this->width, $this->height);
            } else {
                list(, $x0, $y0, $x1, $y1) = $cropSpecs;
                $image->crop($x0, $y0, $x1 - $x0, $y1 - $y0);
                $image->resize($this->width, $this->height, $this->getFlags());
            }
        } else {
            $image->resize($this->width, $this->height, $this->getFlags());
        }

        return $image;
    }

    /**
     * Generate image
     *
     * @param Newscoop\Image\ImageInterface $image
     * @return Nette\Image
     */
    public function generate(ImageInterface $image)
    {
        return $this->generateImage($image->getPath());
    }

    /**
     * Get aspect ratio
     *
     * @return float
     */
    public function getAspectRatio()
    {
        return (float) $this->width / (float) $this->height;
    }

    /**
     * Get select area
     *
     * @param Newscoop\Image\ImageInterface $image
     * @return array
     */
    public function getSelectArea(ImageInterface $image)
    {
        if ($this->isCrop()) {
            $cropSpecs = explode('_', $this->getSpecs());
            if (count($cropSpecs) > 1) {
                array_shift($cropSpecs);
                return $cropSpecs;
            }
        }

        $ratio = min($image->getWidth() / (float) $this->width, $image->getHeight() / (float) $this->height);
        $width = (int) round($ratio * $this->width);
        $height = (int) round($ratio * $this->height);
        $minx = (int) round(($image->getWidth() - $width) / 2);
        $miny = (int) round(($image->getHeight() - $height) / 2);
        return array($minx, $miny, $minx + $width, $miny + $height);
    }

    /**
     * Get min size
     *
     * @param Newscoop\Image\ImageInterface $image
     * @return array
     */
    public function getMinSize(ImageInterface $image)
    {
        list($width, $height) = NetteImage::calculateSize($image->getWidth(), $image->getHeight(), $this->width, $this->height, $this->getFlags());
        $ratio = max($width / (float) $image->getWidth(), $height / (float) $image->getHeight());
        return array($this->width, $this->height);
    }

    /**
     * Get flags
     *
     * @return int
     */
    private function getFlags()
    {
        $specs = array_shift(explode('_', $this->getSpecs(), 2));
        switch ($specs) {
            case 'fill':
            case 'crop':
                $flags = NetteImage::FILL;
                break;

            case 'fit':
            default:
                $flags = NetteImage::FIT;
                break;
        }

        return $flags;
    }

    /**
     * Test if is crop defined
     *
     * @return bool
     */
    public function isCrop()
    {
        return strpos($this->specs, 'crop') === 0;
    }

    /**
     * Test if rendition fits image
     *
     * @param ImageInterface $image
     * @return bool
     */
    public function fits(ImageInterface $image = null)
    {
        if (is_null($image)) {
            throw new \InvalidArgumentException("No image to fit.");
        }

        return $this->specs === 'fit' || ($image->getWidth() >= $this->width && $image->getHeight() >= $this->height);
    }

    /**
     * Set offset
     *
     * @param int $offset
     * @return void
     */
    public function setOffset($offset)
    {
        $this->offset = (int) $offset;
    }

    /**
     * Set label
     *
     * @param string $label
     * @return void
     */
    public function setLabel($label)
    {
        $this->label = empty($label) ? null : (string) $label;
    }

    /**
     * Get label
     *
     * @return string
     */
    public function getLabel()
    {
        return $this->label !== null ? $this->label : $this->getName();
    }
}
