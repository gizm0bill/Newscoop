<?php

namespace Guzzle\Service\Description;

use Guzzle\Service\Exception\DescriptionBuilderException;

/**
 * Build service descriptions using a JSON document
 */
class JsonDescriptionBuilder implements DescriptionBuilderInterface
{
    public static function parseJsonFile($jsonFile)
    {
        $json = file_get_contents($jsonFile);
        if (false === $json) {
            throw new DescriptionBuilderException('Error loading data from ' . $jsonFile);
        }

        $data = json_decode($json, true);

        // Handle includes
        if (!empty($data['includes'])) {
            foreach ($data['includes'] as $path) {
                if ($path[0] != DIRECTORY_SEPARATOR) {
                    $path = dirname($jsonFile) . DIRECTORY_SEPARATOR . $path;
                }
                $data = array_merge_recursive(self::parseJsonFile($path), $data);
            }
        }

        return $data;
    }

    /**
     * {@inheritdoc}
     */
    public static function build($filename)
    {
        return ServiceDescription::factory(self::parseJsonFile($filename));
    }
}
