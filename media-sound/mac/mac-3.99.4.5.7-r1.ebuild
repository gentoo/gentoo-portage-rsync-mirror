# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mac/mac-3.99.4.5.7-r1.ebuild,v 1.5 2012/09/30 18:26:06 armin76 Exp $

EAPI=4
inherit flag-o-matic versionator

MY_PV=$(version_format_string '$1.$2-u$3-b$4')
PATCH=s$(get_version_component_range 5)
MY_P=${PN}-${MY_PV}-${PATCH}

DESCRIPTION="Monkey's Audio Codecs"
HOMEPAGE="http://etree.org/shnutils/shntool/"
SRC_URI="http://etree.org/shnutils/shntool/support/formats/ape/unix/${MY_PV}-${PATCH}/${MY_P}.tar.gz"

LICENSE="mac"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE="mmx static-libs"

RDEPEND=""
DEPEND="sys-apps/sed
	mmx? ( dev-lang/yasm )"

S=${WORKDIR}/${MY_P}

RESTRICT="mirror"

src_prepare() {
	sed -i -e 's:-O3::' configure || die
}

pkg_setup() {
	append-cppflags -DSHNTOOL
	use mmx && append-ldflags -Wl,-z,noexecstack
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable mmx assembly)
}

src_install() {
	default

	insinto /usr/include/${PN}
	doins src/MACLib/{BitArray,UnBitArrayBase,Prepare}.h #409435

	dodoc ChangeLog.shntool src/*.txt
	dohtml src/Readme.htm

	find "${ED}"/usr -type f -name '*.la' -exec rm -f {} +
}
