# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/metacity-themes/metacity-themes-1.2.ebuild,v 1.8 2013/01/16 22:27:24 ulm Exp $

inherit eutils

DESCRIPTION="Some nice themes for MetaCity"
S=${WORKDIR}
THEME_URI="http://ftp.gnome.org/pub/GNOME/teams/art.gnome.org/themes/metacity/"
SRC_URI="${THEME_URI}CityBox-0.10.tar.gz
	${THEME_URI}MCity-BeautifulAndFree-0.1.tar.gz
	${THEME_URI}MCity-C2.tar.gz
	${THEME_URI}MCity-Carved-1.0.tar.gz
	${THEME_URI}MCity-Cazador.tar.gz
	${THEME_URI}MCity-ClearboxLookBis.tar.gz
	${THEME_URI}MCity-Clearlooks2Squared.tar.bz2
	${THEME_URI}MCity-Clearlooks2SquaredBerries.tar.gz
	${THEME_URI}MCity-ClearlooksBlend.tar.bz2
	${THEME_URI}MCity-ClearlooksWithACherryOnTop.tar.gz
	${THEME_URI}MCity-CorrecaminsTheme1.tar.bz2
	${THEME_URI}MCity-Gilouche.tar.gz
	${THEME_URI}MCity-Iris.tar.gz
	${THEME_URI}MCity-Keramik-SCO-Blue-0.1.tar.gz
	${THEME_URI}MCity-McBlue-1.0.tar.gz
	${THEME_URI}MCity-MetaGrip.tar.gz
	${THEME_URI}MCity-MetaMile-Marker-0.2.tar.gz
	${THEME_URI}MCity-Mista.tar.bz2
	${THEME_URI}MCity-Outline.tar.gz
	${THEME_URI}MCity-Posh.tar.gz
	${THEME_URI}MCity-PrettyMeta-Thin-0.1.tar.gz
	${THEME_URI}MCity-Quiet-Purple.tar.gz
	${THEME_URI}MCity-ShinyTango.tar.gz
	${THEME_URI}MCity-TangoDance.tar.bz2
	${THEME_URI}MCity-TigertCrack-1.2.1.tar.gz
	${THEME_URI}MCity-VistaBasic.tar.gz
	${THEME_URI}MCity-W2k.tar.gz
	${THEME_URI}SmallPill-Citrus-0.2.tar.gz"
# File collisions with gnome-themes
#	${THEME_URI}MCity-Clearlooks2.tar.gz

HOMEPAGE="http://art.gnome.org/themes/metacity/"

RDEPEND="x11-wm/metacity"
DEPEND="${RDEPEND}"

LICENSE="GPL-2 public-domain"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

src_unpack() {
	return 0
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/share/themes
	cd "${D}/usr/share/themes"

	unpack ${A}

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
}
