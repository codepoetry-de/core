<?php
/**
 * TYPOlight Repository :: Template to display a single extension
 *
 * NOTE: this file was edited with tabs set to 4.
 * @package Repository
 * @copyright Copyright (C) 2008 by Peter Koch, IBK Software AG
 * @license See accompaning file LICENSE.txt
 */
?>
<?php
	$rep = &$this->rep;
	$theme = &$rep->theme;
	$text = &$GLOBALS['TL_LANG']['tl_repository'];
	$type_options = &$GLOBALS['TL_LANG']['tl_repository_type_options'];
	$category_options = &$GLOBALS['TL_LANG']['tl_repository_category_options'];
	$ext = &$rep->extensions[0];
	$langs = property_exists($ext, 'languages') && count($ext->languages)>0;
?>

<div id="tl_buttons">
<a href="typolight/main.php?do=repository_catalog" class="header_back" title="<?php echo $text['goback']; ?>" accesskey="b" onclick="Backend.getScrollOffset();"><?php echo $text['goback']; ?></a>
</div>

<div class="mod_repository mod_repository_view block">
<form action="<?php echo $rep->f_link; ?>" id="repository_editform" method="post">
<div class="extension_container">
<input type="hidden" name="repository_action" value="<?php echo $rep->f_action; ?>" />

<table cellpadding="0" cellspacing="0" class="extension" summary="">
<tr class="title">
  <th colspan="4">
	<span class="title">[<?php echo $ext->name; ?>] <?php echo $ext->title; ?></span>
	<span class="actions">
<?php if (property_exists($ext, 'packageLink')) { ?>
	  <a href="<?php echo $ext->packageLink; ?>" title="<?php echo $text['downloadpackage']; ?>">
<?php echo $rep->theme->createImage('download16',$text['downloadpackage'],'title="'.$text['downloadpackage'].'"'); ?>
	  </a>
<?php } // if ext->packageLink ?>
	</span>
  </th>
</tr>
<tr class="description">
  <td colspan="4">
<?php if (property_exists($ext, 'thumbnail')) { ?>
  <div class="image_container">
    <a href="<?php echo $ext->picture->url; ?>" title="<?php echo $text['showpicture']; ?>"><img src="<?php echo $ext->thumbnail->url; ?>" alt="<?php echo $text['thumbnail']; ?>" width="<?php echo $ext->thumbnail->width; ?>" height="<?php echo $ext->thumbnail->height; ?>" class="thumbnail" /></a>
  </div>
<?php } // if ext thumbnail ?>
<?php if ($ext->teaser!='') { ?>
  <h2><?php echo $ext->teaser; ?></h2>
<?php } // if ext teaser ?>
  <?php echo $ext->description; ?>
  </td>
</tr>
<tr class="spacer"><td colspan="4" class="spacer">&nbsp;</td></tr>
<tr>
  <th class="viewcol1"><?php echo $text['version'][0]; ?></th>
  <td class="viewcol2 status-<?php echo $ext->version % 10; ?>"><?php echo Repository::formatVersion($ext->version); ?></td>
  <th class="viewcol3"><?php echo $text['type'][0]; ?></th>
  <td class="type-<?php echo $ext->type; ?>"><?php echo $type_options[$ext->type]; ?></td>
</tr>
<tr>
  <th><?php echo $text['releasedate'][0]; ?></th>
  <td><?php echo date($GLOBALS['TL_CONFIG']['dateFormat'], $ext->releasedate); ?></td>
<?php if ($ext->type=='commercial') { ?> 
  <th><?php echo $text['demo'][0]; ?></th>
  <td><?php echo $ext->demo ? $text['yes'] : $text['no']; ?></td>
<?php } else { ?>
  <th>&nbsp;</th>
  <td>&nbsp;</td>
<?php } // if free ?>
</tr>
<tr>
  <th><?php echo $text['license'][0]; ?></th>
  <td><?php echo $ext->license; ?></td>
  <th><?php echo $text['category'][0]; ?></th>
  <td><?php echo $category_options[$ext->category]; ?></td>
</tr>
<tr class="spacer"><td colspan="4" class="spacer">&nbsp;</td></tr>
<tr>
  <th><?php echo $text['copyright'][0]; ?></th>
  <td colspan="3"><?php echo $ext->copyright; ?></td>
</tr>
<tr>
  <th><?php echo $text['author']; ?></th>
  <td colspan="3">
<?php echo property_exists($ext,'authorname') ? $ext->authorname.' ('.$ext->author.')' : $ext->author; ?>
<?php if (property_exists($ext,'authorsite')) { ?>
  <a href="<?php echo  $ext->authorsite; ?>"><?php echo  $ext->authorsite; ?></a>
<?php } // if website ?>
  </td>
</tr>
<?php if ($ext->translator != $ext->author) { ?>
<tr>
  <th><?php echo sprintf($text['langtrans'], $GLOBALS['TL_LANG']['LNG'][$ext->language]); ?></th>
  <td colspan="3">
<?php echo property_exists($ext,'translatorname') ? $ext->translatorname.' ('.$ext->translator.')' : $ext->translator; ?>
<?php if (property_exists($ext,'translatorsite')) { ?>
  <a href="<?php echo  $ext->translatorsite; ?>"><?php echo  $ext->translatorsite; ?></a>
<?php } // if website ?>
  </td>
</tr>
<?php } // if translator ?>
<tr class="spacer"><td colspan="4" class="spacer">&nbsp;</td></tr>
<tr>
  <th colspan="3"><?php echo sprintf($text['releasenotesfor'], Repository::formatVersion($ext->version)); ?></th>
  <th><?php echo $text['versions']; ?></th>
</tr>
<tr>
  <td colspan="3"<?php if ($langs) echo ' rowspan="3"'; ?> class="releasenotes"><?php echo $ext->releasenotes; ?></td>
  <td>
<?php 
if (property_exists($ext, 'allversions'))
	foreach ($ext->allversions as $ver) 
		if ($ver->version != $ext->version) { ?>
    <a href="<?php echo $ver->viewLink; ?>"><?php echo Repository::formatVersion($ver->version); ?></a><br/>
<?php 	} // if ?>
  </td>
</tr>
<?php if ($langs) { ?>
<tr>
  <th style="height:20px"><?php echo $text['otherlanguages']; ?></th>
</tr>
<tr>
  <td>
<?php 
	foreach ($ext->languages as $lng) 
		if ($lng->language != $ext->language) { ?>
 <a href="<?php echo $lng->link; ?>"><?php echo $GLOBALS['TL_LANG']['LNG'][$lng->language]; ?></a>
<?php 	} // if ?>
  </td>
</tr>
<?php } // if $langs ?>
<tr class="spacer"><td colspan="4" class="spacer">&nbsp;</td></tr>
<?php if (property_exists($ext, 'votes')) { ?>
<tr>
  <th><?php echo $text['relfunctionality']; ?></th>
  <td class="nowrap">
<?php if (property_exists($ext, 'rel_votes')) { ?>
    <div class="ratebarframe"><div class="ratebar" style="width:<?php echo $ext->rel_functionality*10.0; ?>%"></div></div>
	<div class="ratebartext"><?php echo sprintf('%.2f', $ext->rel_functionality); ?></div>
<?php } // if votes ?>
  </td>
  <th><?php echo $text['totfunctionality']; ?></th>
  <td class="nowrap">
    <div class="ratebarframe"><div class="ratebar" style="width:<?php echo $ext->functionality*10.0; ?>%"></div></div>
	<div class="ratebartext"><?php echo sprintf('%.2f', $ext->functionality); ?></div>
  </td>
</tr>
<tr>
  <th><?php echo $text['relusability']; ?></th>
  <td class="nowrap">
<?php if (property_exists($ext, 'rel_votes')) { ?>
    <div class="ratebarframe"><div class="ratebar" style="width:<?php echo $ext->rel_usability*10.0; ?>%"></div></div>
	<div class="ratebartext"><?php echo sprintf('%.2f', $ext->rel_usability); ?></div>
<?php } // if votes ?>
  </td>
  <th><?php echo $text['totusability']; ?></th>
  <td class="nowrap">
    <div class="ratebarframe"><div class="ratebar" style="width:<?php echo $ext->usability*10.0; ?>%"></div></div>
	<div class="ratebartext"><?php echo sprintf('%.2f', $ext->usability); ?></div>
  </td>
</tr>
<tr>
  <th><?php echo $text['relquality']; ?></th>
  <td class="nowrap">
<?php if (property_exists($ext, 'rel_votes')) { ?>
    <div class="ratebarframe"><div class="ratebar" style="width:<?php echo $ext->rel_quality*10.0; ?>%"></div></div>
	<div class="ratebartext"><?php echo sprintf('%.2f', $ext->rel_quality); ?></div>
<?php } // if votes ?>
  </td>
  <th><?php echo $text['totquality']; ?></th>
  <td class="nowrap">
    <div class="ratebarframe"><div class="ratebar" style="width:<?php echo $ext->quality*10.0; ?>%"></div></div>
	<div class="ratebartext"><?php echo sprintf('%.2f', $ext->quality); ?></div>
  </td>
</tr>
<tr>
  <th><?php echo $text['relrating']; ?></th>
  <td class="nowrap">
<?php if (property_exists($ext, 'rel_votes')) { ?>
    <div class="ratebarframe"><div class="ratebar" style="width:<?php echo $ext->rel_rating*10.0; ?>%"></div></div>
	<div class="ratebartext"><?php echo sprintf($text['ratingfmt'], $ext->rel_rating, $ext->rel_votes); ?></div>
<?php } // if votes ?>
  </td>
  <th><?php echo $text['totrating']; ?></th>
  <td class="nowrap">
    <div class="ratebarframe"><div class="ratebar" style="width:<?php echo $ext->rating*10.0; ?>%"></div></div>
	<div class="ratebartext"><?php echo sprintf($text['ratingfmt'], $ext->rating, $ext->votes); ?></div>
  </td>
</tr>
<tr class="spacer"><td colspan="4" class="spacer">&nbsp;</td></tr>
<?php } // if totvotes ?>
<?php if (property_exists($ext, 'downloads')) { ?>
<tr>
  <th><?php echo $text['reldownloads']; ?></th>
  <td><?php echo $ext->rel_downloads; ?></td>
  <th><?php echo $text['totdownloads']; ?></th>
  <td><?php echo $ext->downloads; ?></td>
</tr>
<?php } // if downloads ?>
<?php if (property_exists($ext, 'installs')) { ?>
<tr>
  <th><?php echo $text['relinstalls']; ?></th>
  <td><?php echo $ext->rel_installs; ?></td>
  <th><?php echo $text['totinstalls']; ?></th>
  <td><?php echo $ext->installs; ?></td>
</tr>
<?php } // if installs ?>
<?php if (property_exists($ext, 'updates')) { ?>
<tr>
  <th><?php echo $text['relupdates']; ?></th>
  <td><?php echo $ext->rel_updates; ?></td>
  <th><?php echo $text['totupdates']; ?></th>
  <td><?php echo $ext->updates; ?></td>
</tr>
<?php } // if updates ?>
<tr class="spacer"><td colspan="4" class="spacer">&nbsp;</td></tr>
<tr>
  <th colspan="2"><?php echo $text['dependencies']; ?></th>
  <th colspan="2"><?php echo $text['dependents']; ?></th>
</tr>
<tr>
  <td colspan="2" class="nopadding">
    <table cellpadding="0" cellspacing="0" class="nested" summary="">
      <tr><th><?php echo $text['name'][0]; ?></th><th><?php echo $text['versionfrom']; ?></th><th><?php echo $text['versionto']; ?></th></tr>
      <tr>
	    <td>TYPOlight</td>
	    <td><?php echo Repository::formatCoreVersion($ext->coreminversion); ?></td>
	    <td><?php echo Repository::formatCoreVersion($ext->coremaxversion); ?></td>
      </tr>
<?php if (property_exists($ext, 'dependencies')) { ?>
<?php foreach ($ext->dependencies as $dep) { ?>
      <tr>
	    <td><a href="<?php echo $dep->viewLink; ?>"><?php echo $dep->extension; ?></a></td>
	    <td><?php echo Repository::formatVersion($dep->minversion); ?></td>
	    <td><?php echo Repository::formatVersion($dep->maxversion); ?></td>
      </tr>
<?php } // foreach ext dependencies ?>
<?php } // if ext dependencies ?>
    </table>
  </td>
  <td colspan="2" class="nopadding">
    <table cellpadding="0" cellspacing="0" class="nested" summary="">
      <tr><th><?php echo $text['name'][0]; ?></th><th><?php echo $text['versionfrom']; ?></th><th><?php echo $text['versionto']; ?></th></tr>
<?php if (property_exists($ext, 'dependents')) { ?>
<?php foreach ($ext->dependents as $dep) { ?>
      <tr>
	    <td><a href="<?php echo $dep->viewLink; ?>"><?php echo $dep->extension; ?></a></td>
	    <td><?php echo Repository::formatVersion($dep->minversion); ?></td>
	    <td><?php echo Repository::formatVersion($dep->maxversion); ?></td>
      </tr>
<?php } // foreach ext dependencies ?>
<?php } // if ext dependencies ?>
    </table>
  </td>
</tr>

</table>
</div>

<div class="mod_repository_submit tl_formbody_submit">
<div class="tl_submit_container">
<input type="submit" name="repository_installbutton" class="tl_submit" value="<?php echo $text['install']; ?>" />
<?php if (property_exists($ext, 'manual')) { ?>
<input type="submit" name="repository_manualbutton" class="tl_submit" value="<?php echo $text['manual']; ?>" onclick="window.open('<?php echo $ext->manual; ?>'); return false;" />
<?php } // if manual ?>
<?php if (property_exists($ext, 'forum')) { ?>
<input type="submit" name="repository_forumbutton" class="tl_submit" value="<?php echo $text['forum']; ?>" onclick="window.open('<?php echo $ext->forum; ?>'); return false;" />
<?php } // if forum ?>
<?php if (property_exists($ext, 'shop')) { ?>
<input type="submit" name="repository_shopbutton" class="tl_submit" value="<?php echo $text[$ext->type=='free' ? 'donate' : 'shop']; ?>" onclick="window.open('<?php echo $ext->shop; ?>'); return false;" />
<?php } // if shop ?>
</div>
</div>

</form>
</div>

