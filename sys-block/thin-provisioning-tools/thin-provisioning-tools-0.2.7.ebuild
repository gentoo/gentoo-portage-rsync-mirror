# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/thin-provisioning-tools/thin-provisioning-tools-0.2.7.ebuild,v 1.1 2013/10/07 13:14:49 ssuominen Exp $

EAPI=5
inherit autotools eutils toolchain-funcs versionator

DESCRIPTION="A suite of tools for thin provisioning on Linux."
HOMEPAGE="https://github.com/jthornber/thin-provisioning-tools"
EXT=.tar.gz
SRC_URI="http://github.com/jthornber/${PN}/archive/v${PV}${EXT} -> ${P}${EXT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-lang/ruby
	dev-libs/expat"
DEPEND="${RDEPEND}
	dev-libs/boost"

pkg_pretend() {
	[[ $(tc-getCXX) == *g++ ]] && ! version_is_at_least 4.7 $(gcc-version) && \
		die "You need at least GNU GCC 4.7.x to build this package."
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch
	eautoreconf
}

src_configure() {
	econf \
		--prefix="${EPREFIX}/" \
		--bindir="${EPREFIX}/sbin" \
		--with-optimisation=""
}

src_install() {
	emake install DESTDIR="${D}" MANDIR=/usr/share/man
	dodoc README.md TODO.org
}
