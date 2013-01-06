# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/java-access-bridge/java-access-bridge-1.26.2.ebuild,v 1.5 2012/12/08 21:40:27 ago Exp $

EAPI=4
GNOME_TARBALL_SUFFIX="bz2"
GNOME2_LA_PUNT="yes"

inherit java-pkg-2 gnome2 eutils autotools

DESCRIPTION="Gnome Java Accessibility Bridge"
HOMEPAGE="https://live.gnome.org/Java%20Access%20Bridge/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

COMMON_DEPEND=">=gnome-base/libbonobo-2
	>=gnome-extra/at-spi-1.7.10:1
	x11-apps/xprop"

RDEPEND="$COMMON_DEPEND
	>=virtual/jre-1.4"

DEPEND="$COMMON_DEPEND
	>=virtual/jdk-1.4
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	java-pkg-2_src_prepare
	epatch "${FILESDIR}"/${PN}-1.6.0-missingclasses.patch
	eautoreconf
}

pkg_setup() {
	java-pkg-2_pkg_setup
	G2CONF+="--disable-static
		--with-java-home=${JDK_HOME}"
}

src_configure() {
	gnome2_src_configure
}

src_compile() {
	emake JAVAC="${JAVAC} ${JAVACFLAGS}"
}

src_install() {
	gnome2_src_install

	java-pkg_dojar "${D}"/usr/share/jar/*.jar

	insinto /usr/share/${PN}
	doins "${D}"/usr/share/jar/*.properties

	rm -rf "${D}"/usr/share/jar
}

pkg_preinst() {
	java-pkg-2_pkg_preinst
	gnome2_pkg_preinst
}

pkg_postinst() {
	elog
	elog "To enable accessibility support with your java applications, you"
	elog "have to enable CORBA traffic over IP. To do this, you may add the"
	elog "following line to your /etc/orbitrc or ~/.orbitrc file:"
	elog
	elog "  ORBIIOPIPv4=1"
	elog
}
