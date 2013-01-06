# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gnumail/gnumail-1.2.0_pre3-r1.ebuild,v 1.8 2011/06/06 09:09:49 voyageur Exp $

inherit gnustep-2

MY_PN=${PN/gnum/GNUM}

S="${WORKDIR}"/${MY_PN}

DESCRIPTION="A fully featured mail application for GNUstep"
HOMEPAGE="http://www.collaboration-world.com/gnumail/"
SRC_URI="http://www.collaboration-world.com/gnumail.data/releases/Stable/${MY_PN}-${PV/_/}.tar.gz"

KEYWORDS="amd64 ppc x86 ~x86-fbsd"
LICENSE="GPL-2"
SLOT="0"

IUSE="crypt emoticon xface"
DEPEND="~gnustep-libs/pantomime-${PV}
	>=gnustep-base/gnustep-gui-0.11.0
	|| ( gnustep-apps/addresses gnustep-libs/addresseskit )"
RDEPEND="crypt? ( app-crypt/gnupg )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-index.patch
	epatch "${FILESDIR}"/${P}-pgpversion.patch
	sed -i -e 's|GNUMail_GUI_LIBS =|LIBRARIES_DEPEND_UPON +=|' \
		Framework/GNUMail/GNUmakefile || die "as-needed sed failed"
	sed -i -e \
		's|$(GNUSTEP_INSTALLATION_DIR)/Library|$(DESTDIR)$(GNUSTEP_SYSTEM_LIBRARY)|' \
		Bundles/*/GNUmakefile || die "gnustep-make-2 sed failed"
}

src_compile() {
	egnustep_env
	egnustep_make

	cd Bundles/Clock
	egnustep_make
	cd "${S}"

	if use xface ; then
		cd Bundles/Face
		egnustep_make
		cd "${S}"
	fi

	if use crypt ; then
		cd Bundles/PGP
		egnustep_make
		cd "${S}"
	fi

	if use emoticon ; then
		cd Bundles/Emoticon
		egnustep_make
		cd "${S}"
	fi
}

src_install() {
	gnustep-base_src_install

	cd Bundles/Clock
	egnustep_install
	cd "${S}"

	if use xface ; then
		cd Bundles/Face
		egnustep_install
		cd "${S}"
	fi
	if use crypt ; then
		cd Bundles/PGP
		egnustep_install
		cd "${S}"
	fi
	if use emoticon ; then
		cd Bundles/Emoticon
		egnustep_install
		cd "${S}"
	fi

	dodoc "${S}"/Documentation/*

	# FIX ?
	rm -rf "${D}"$(egnustep_install_domain)/Applications/GNUMail.app/Resources/Resources
}
