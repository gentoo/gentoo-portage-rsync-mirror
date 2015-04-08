# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/icedtea-sound/icedtea-sound-1.0.1.ebuild,v 1.1 2014/11/01 19:04:52 caster Exp $
# Build written by Andrew John Hughes (gnu_andrew@member.fsf.org)

EAPI="5"

inherit eutils java-pkg-2 prefix

DESCRIPTION="Plugins for javax.sound"
HOMEPAGE="http://icedtea.classpath.org"
SRC_URI="http://icedtea.classpath.org/download/source/${P}.tar.xz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+doc test"

COMMON_DEP="
	>=virtual/jdk-1.6.0
	>=media-sound/pulseaudio-0.9.11:="
RDEPEND="${COMMON_DEP}"
DEPEND="${COMMON_DEP}"

pkg_setup() {
	JAVA_PKG_WANT_SOURCE="1.6"
	JAVA_PKG_WANT_TARGET="1.6"

	java-pkg-2_pkg_setup
}

src_configure() {
	econf --with-jdk-home="${JAVA_HOME}" \
		$(use_enable doc docs) \
		--htmldir="${EROOT}usr/share/doc/${PF}/html"
}

src_compile() {
	default
}
