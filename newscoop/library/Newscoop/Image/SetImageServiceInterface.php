<?php
/**
 * @package Newscoop
 * @copyright 2012 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Image;

/**
 * Set Image Service Interface
 */
interface SetImageServiceInterface
{
    /**
     * Set image service
     *
     * @param Newscoop\Image\ImageService $imageService
     * @return void
     */
    public function setImageService(ImageService $imageService);
}
