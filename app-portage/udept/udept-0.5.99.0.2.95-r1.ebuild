# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/udept/udept-0.5.99.0.2.95-r1.ebuild,v 1.4 2010/04/07 04:22:24 darkside Exp $

inherit bash-completion eutils

DESCRIPTION="A Portage analysis toolkit"
HOMEPAGE="http://catmur.co.uk/gentoo/udept"
SRC_URI="http://files.catmur.co.uk/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~mips ~sparc ~x86"
IUSE=""

DEPEND="app-shells/bash
	sys-apps/portage"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/udept.default-use.patch"
}

src_compile() {
	econf $(use_enable bash-completion) || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog*
}

pkg_postinst() {
	BASHCOMPLETION_NAME="dep"
	bash-completion_pkg_postinst
}
