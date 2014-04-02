# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/moarvm/moarvm-2013.10.1.ebuild,v 1.4 2014/04/02 04:50:32 patrick Exp $

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
DEPEND="${RDEPEND}
	dev-lang/perl"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}/Configure.patch" || die
	echo "${PV}" > VERSION
}

src_configure() {
	perl Configure.pl --prefix="${D}/usr"|| die
}

src_install() {
	make install
}
