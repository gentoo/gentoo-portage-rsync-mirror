# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/moarvm/moarvm-9999.ebuild,v 1.1 2014/01/09 08:16:03 patrick Exp $

EAPI=5

inherit eutils git-r3

MY_PN="MoarVM"

DESCRIPTION="A 6model-based VM for NQP and Rakudo Perl 6"
HOMEPAGE="https://github.com/MoarVM/MoarVM"
EGIT_REPO_URI="https://github.com/MoarVM/MoarVM.git"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND=""
DEPEND="${RDEPEND}"

src_configure() {
        perl Configure.pl --prefix="${D}/usr"|| die
}

src_install() {
	make install
}
