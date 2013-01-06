# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-dsa/crypt-dsa-1.16.ebuild,v 1.10 2011/04/24 15:57:52 grobian Exp $

EAPI=2

MY_PN=Crypt-DSA
MY_P=${MY_PN}-${PV}
MODULE_AUTHOR=ADAMK
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="DSA Signatures and Key Generation"

SLOT="0"
KEYWORDS="alpha amd64 hppa ~ppc sparc x86 ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/data-buffer
	dev-perl/Digest-SHA1
	virtual/perl-File-Spec
	dev-perl/File-Which
	virtual/perl-MIME-Base64
	>=virtual/perl-Math-BigInt-1.78"
DEPEND="test? ( ${RDEPEND}
		dev-perl/Math-BigInt-GMP )"

SRC_TEST="do"

PATCHES=( "${FILESDIR}/${P}-dsaparam.patch" )
