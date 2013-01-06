# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-speech/gnome-speech-0.4.25-r1.ebuild,v 1.9 2012/05/03 01:48:59 jdhore Exp $

EAPI="4"
GNOME_TARBALL_SUFFIX="bz2"

inherit gnome2 eutils

DESCRIPTION="Simple general API for producing text-to-speech output"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="+espeak festival"

COMMON_DEPEND=">=gnome-base/orbit-2.3.94
	>=gnome-base/libbonobo-1.97
	>=dev-libs/glib-2:2
	espeak? ( app-accessibility/espeak )"

RDEPEND="$COMMON_DEPEND
	festival? ( app-accessibility/festival )"

DEPEND="$COMMON_DEPEND
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF} $(use_with festival) --with-speech-dispatcher"

	if ! use espeak; then
		 G2CONF="${G2CONF} --without-espeak-dir"
	fi

	# We don't want java support at all as configure is broken and nothing needs it
	export JAVAC=no
}

src_prepare() {
	gnome2_src_prepare

	epatch "${FILESDIR}/${P}-disable-java.patch"
	epatch "${FILESDIR}/${P}-glib-2.31.patch"

	sed -i \
		-e 's:\(GNOME_SPEECH_JAR_DIR=\).*:\1"/usr/share/java-access-bridge/lib/":' \
		-e 's:\(FREETTS_DRIVER_JAR_DIR=\).*:\1"/usr/share/java-access-bridge/lib/":' \
		"${S}"/configure
}
