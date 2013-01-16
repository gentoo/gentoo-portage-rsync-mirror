# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/metacity-themes/metacity-themes-1.3-r1.ebuild,v 1.7 2013/01/16 22:27:23 ulm Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Some nice themes for MetaCity"
S=${WORKDIR}
THEME_URI="http://ftp.gnome.org/pub/GNOME/teams/art.gnome.org/themes/metacity/"
SRC_URI="${THEME_URI}CityBox-0.10.tar.gz
	${THEME_URI}MCity-BeautifulAndFree-0.1.tar.gz
	${THEME_URI}MCity-C2.tar.gz
	${THEME_URI}MCity-Carved-1.0.tar.gz
	${THEME_URI}MCity-Cazador.tar.gz
	${THEME_URI}MCity-Iris.tar.gz
	${THEME_URI}MCity-Keramik-SCO-Blue-0.1.tar.gz
	${THEME_URI}MCity-McBlue-1.0.tar.gz
	${THEME_URI}MCity-MetaMile-Marker-0.2.tar.gz
	${THEME_URI}MCity-Outline.tar.gz
	${THEME_URI}MCity-Posh.tar.gz
	${THEME_URI}MCity-PrettyMeta-Thin-0.1.tar.gz
	${THEME_URI}MCity-Quiet-Purple.tar.gz
	${THEME_URI}MCity-TigertCrack-1.2.1.tar.gz
	${THEME_URI}SmallPill-Citrus-0.2.tar.gz
	${THEME_URI}MCity-4DWM.tar.gz
	${THEME_URI}MCity-Agata.tar.bz2
	${THEME_URI}MCity-Almond.tar.gz
	${THEME_URI}MCity-Alphacube.tar.gz
	${THEME_URI}MCity-AlphacubeMetacity.tar.gz
	${THEME_URI}MCity-Amiga.tar.gz
	${THEME_URI}MCity-AmigaRelief.tar.gz
	${THEME_URI}MCity-Aquarius.tar.gz
	${THEME_URI}MCity-Bentham.tar.gz
	${THEME_URI}MCity-Black.tar.gz
	${THEME_URI}MCity-BlueSky.tar.gz
	${THEME_URI}MCity-BlueSkyFixedBar.tar.gz
	${THEME_URI}MCity-Boxx.tar.gz
	${THEME_URI}MCity-C2.tar.gz
	${THEME_URI}MCity-Carved2.tar.gz
	${THEME_URI}MCity-Chiro.tar.gz
	${THEME_URI}MCity-Clearbox.tar.gz
	${THEME_URI}MCity-ClearboxLookBis.tar.gz
	${THEME_URI}MCity-Clearlooks2Squared.tar.bz2
	${THEME_URI}MCity-Clearlooks2SquaredBerries.tar.gz
	${THEME_URI}MCity-ClearlooksBlend.tar.bz2
	${THEME_URI}MCity-ClearlooksPinstripe.tar.gz
	${THEME_URI}MCity-ClearlooksRedExit.tar.bz2
	${THEME_URI}MCity-ClearlooksWithACherryOnTop.tar.gz
	${THEME_URI}MCity-CorrecaminsTheme1.tar.bz2
	${THEME_URI}MCity-EasyListening.tar.bz2
	${THEME_URI}MCity-Firey.tar.bz2
	${THEME_URI}MCity-Gilouche.tar.gz
	${THEME_URI}MCity-GiloucheIM.tar.gz
	${THEME_URI}MCity-Graphite.tar.gz
	${THEME_URI}MCity-GraySky.tar.gz
	${THEME_URI}MCity-GraySkyFixedBar.tar.gz
	${THEME_URI}MCity-MWM.tar.gz
	${THEME_URI}MCity-Maemo.tar.gz
	${THEME_URI}MCity-MetaGrip.tar.gz
	${THEME_URI}MCity-Mista.tar.bz2
	${THEME_URI}MCity-Outcrop.tar.gz
	${THEME_URI}MCity-POS.tar.gz
	${THEME_URI}MCity-QuietEnvironment.tar.gz
	${THEME_URI}MCity-QuietEnvironmentV2.tar.gz
	${THEME_URI}MCity-QuietGraphite.tar.gz
	${THEME_URI}MCity-QuietGraphiteV2.tar.gz
	${THEME_URI}MCity-QuietHuman.tar.gz
	${THEME_URI}MCity-QuietPurple2K6.tar.gz
	${THEME_URI}MCity-QuietPurple2K6V2.tar.gz
	${THEME_URI}MCity-Redmond.tar.gz
	${THEME_URI}MCity-River.tar.gz
	${THEME_URI}MCity-SandwishBetter.tar.gz
	${THEME_URI}MCity-Shiny.tar.gz
	${THEME_URI}MCity-ShinyTango.tar.gz
	${THEME_URI}MCity-ShinyTangoSmoother.tar.gz
	${THEME_URI}MCity-Silverado.tar.gz
	${THEME_URI}MCity-Simplebox.tar.gz
	${THEME_URI}MCity-Sloth.tar.gz
	${THEME_URI}MCity-SmoothGNOME.tar.gz
	${THEME_URI}MCity-SoftSquares.tar.gz
	${THEME_URI}MCity-Tactile.tar.gz
	${THEME_URI}MCity-TangoDance.tar.bz2
	${THEME_URI}MCity-TeletelestaiModern.tar.gz
	${THEME_URI}MCity-ThinMC.tar.gz
	${THEME_URI}MCity-VistaBasic.tar.gz
	${THEME_URI}MCity-W2k.tar.gz"

HOMEPAGE="http://art.gnome.org/themes/metacity/"

RDEPEND="x11-wm/metacity"
DEPEND="${RDEPEND}"

LICENSE="GPL-2 LGPL-2.1 CCPL-Attribution-2.0 FreeArt public-domain"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

src_prepare() {
	find "${WORKDIR}"  -exec touch "{}" \;

	for dir in *
	do
		# Fix directory names that contain spaces
		if echo "${dir}" | egrep -q "[[:space:]]"
		then
			new_dir=`echo "${dir}" | sed -e 's: :_:g'`
			mv "${dir}" $new_dir
			dir=$new_dir
		fi

		if [ ! -d "${dir}"/metacity-1 ]
		then
			mkdir tmp
			mv "${dir}"/* tmp
			mv tmp "${dir}"/metacity-1
		fi
	done

	# This patch corrects some XML files that are considered incomplete by
	# Metacity
	epatch "${FILESDIR}/${PN}-1.2-gentoo.diff"

	chmod -R ugo=rX *

	# Remove all of the .xvpics directories, see bug #97368
	find . -type d -iname ".xvpics" | xargs rm -rf

	# Tactile index.theme is provided by x11-themes/tactile, bug #395525
	chmod +w Tactile || die
	rm -f Tactile/index.theme || die
}

src_install() {
	dodir /usr/share/themes
	insinto /usr/share/themes
	doins -r "${WORKDIR}"/*
}
