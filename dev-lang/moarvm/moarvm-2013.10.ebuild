# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/moarvm/moarvm-2013.10.ebuild,v 1.3 2014/01/15 03:09:47 patrick Exp $

EAPI=5

inherit eutils multilib

MY_PN="MoarVM"

DESCRIPTION="A 6model-based VM for NQP and Rakudo Perl 6"
HOMEPAGE="https://github.com/MoarVM/MoarVM"
SRC_URI="http://gentooexperimental.org/~patrick/${MY_PN}-${PV}.tar.bz2"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}/Configure.patch" || die
}

src_configure() {
	perl Configure.pl --prefix="${D}/usr"|| die
}

src_install() {
	make install
}
