# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-speech/gnome-speech-0.4.25.ebuild,v 1.9 2012/05/03 01:48:59 jdhore Exp $

EAPI="1"

JAVA_PKG_OPT_USE="freetts"

inherit java-pkg-opt-2 gnome2

DESCRIPTION="Simple general API for producing text-to-speech output"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="+espeak festival freetts"

COMMON_DEPEND=">=gnome-base/orbit-2.3.94
	>=gnome-base/libbonobo-1.97
	>=dev-libs/glib-2
	espeak? ( app-accessibility/espeak )
	freetts? (
		=app-accessibility/freetts-1.2*
		>=app-accessibility/java-access-bridge-1.4.6 )"

RDEPEND="$COMMON_DEPEND
	freetts? ( >=virtual/jre-1.4 )
	festival? ( app-accessibility/festival )"

DEPEND="$COMMON_DEPEND
	freetts? ( >=virtual/jdk-1.4 )
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_with festival) --with-speech-dispatcher"

	if ! use espeak; then
		 G2CONF="${G2CONF} --without-espeak-dir"
	fi

	if use freetts; then
		java-pkg-opt-2_pkg_setup

		local JABDIR="${ROOT}usr/share/java-access-bridge/lib"

		G2CONF="${G2CONF} --with-java-home=${JAVA_HOME} \
			--with-jab-dir=${JABDIR} \
			--with-freetts-dir=${ROOT}usr/share/freetts/lib"
	else
		export JAVAC=no
	fi
}

src_unpack() {
	gnome2_src_unpack

	if use freetts; then
		sed -i -e \
			's/@GNOME_SPEECH_INSTALLED_CLASSPATH@/$(java-config -p gnome-speech-1,java-access-bridge)/' \
			drivers/freetts/freetts-synthesis-driver.in || die "sed error"
	fi

	sed -i \
		-e 's:\(GNOME_SPEECH_JAR_DIR=\).*:\1"/usr/share/java-access-bridge/lib/":' \
		-e 's:\(FREETTS_DRIVER_JAR_DIR=\).*:\1"/usr/share/java-access-bridge/lib/":' \
		"${S}"/configure
}

src_install() {
	gnome2_src_install

	if use freetts; then
		java-pkg_dojar "${D}"/usr/share/jar/*.jar
		rm -rf "${D}"/usr/share/jar
	fi
}

pkg_postinst() {
	elog
	elog "Gnome Speech has been successfully installed. You may now use the"
	elog "speech interface using app-accessibility/orca."
	elog
}
