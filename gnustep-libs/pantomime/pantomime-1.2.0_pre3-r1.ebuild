# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/pantomime/pantomime-1.2.0_pre3-r1.ebuild,v 1.2 2010/07/07 20:52:11 voyageur Exp $

EAPI=2
inherit eutils gnustep-2

MY_PN=${PN/p/P}

S=${WORKDIR}/${MY_PN}

DESCRIPTION="A set of Objective-C classes that model a mail system."
HOMEPAGE="http://www.collaboration-world.com/pantomime/"
SRC_URI="http://www.collaboration-world.com/pantomime.data/releases/Stable/${MY_PN}-${PV/_/}.tar.gz"

LICENSE="LGPL-2.1 Elm"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
SLOT="0"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gscategories.patch
	sed -i -e "s|ADDITIONAL_LDFLAGS|LIBRARIES_DEPEND_UPON|" \
		Framework/Pantomime/GNUmakefile || die "as-needed sed failed"
}

src_install() {
	gnustep-base_src_install

	cd "${S}"/Documentation
	dodoc AUTHORS README TODO
	docinto rfc
	dodoc RFC/*
}
