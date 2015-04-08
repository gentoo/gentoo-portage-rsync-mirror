# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-OpenPGP/Crypt-OpenPGP-1.60.0-r1.ebuild,v 1.1 2014/08/24 02:34:42 axs Exp $

EAPI=5

MODULE_AUTHOR=BTROTT
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="Pure-Perl OpenPGP-compatible PGP implementation"

LICENSE="Artistic"
#LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-solaris"
IUSE="test"

# Core dependancies are:
# >=Data-Buffer 0.04
# MIME-Base64
# Math-Pari
# Compress-Zlib
# LWP-UserAgent
# URI-Escape

RDEPEND="
	>=dev-perl/data-buffer-0.04
	virtual/perl-MIME-Base64
	virtual/perl-Math-BigInt
	virtual/perl-IO-Compress
	dev-perl/libwww-perl
	dev-perl/URI
	dev-perl/crypt-dsa
	dev-perl/crypt-rsa
	dev-perl/File-HomeDir

	dev-perl/crypt-idea
	virtual/perl-Digest-MD5

	dev-perl/crypt-des-ede3
	dev-perl/Digest-SHA1

	dev-perl/Crypt-Rijndael
	dev-perl/Crypt-CAST5_PP
	dev-perl/Crypt-RIPEMD160

	dev-perl/Crypt-Blowfish
	>=dev-perl/Crypt-Twofish-2.00
	"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Exception
	)"

SRC_TEST="do"
