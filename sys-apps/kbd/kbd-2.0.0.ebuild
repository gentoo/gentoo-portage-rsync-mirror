# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kbd/kbd-2.0.0.ebuild,v 1.5 2013/09/17 02:46:10 radhermit Exp $

EAPI="5"

inherit autotools eutils

DESCRIPTION="Keyboard and console utilities"
HOMEPAGE="http://kbd-project.org/"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/kbd/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls pam test"

RDEPEND="pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-libs/check )"

src_unpack() {
	default
	cd "${S}"

	# broken file ... upstream git punted it
	rm po/es.po

	# Rename conflicting keymaps to have unique names, bug #293228
	cd "${S}"/data/keymaps/i386
	mv dvorak/no.map dvorak/no-dvorak.map
	mv fgGIod/trf.map fgGIod/trf-fgGIod.map
	mv olpc/es.map olpc/es-olpc.map
	mv olpc/pt.map olpc/pt-olpc.map
	mv qwerty/cz.map qwerty/cz-qwerty.map
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-tests.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable pam vlock) \
		$(use_enable test tests)
}

src_install() {
	default
	dohtml docs/doc/*.html
}
