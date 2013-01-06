# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-Das/Bio-Das-1.170.0.ebuild,v 1.2 2012/12/20 17:34:09 jlec Exp $

EAPI=4

MODULE_AUTHOR=LDS
MODULE_VERSION=1.17
inherit perl-module

DESCRIPTION="Interface to Distributed Annotation System"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/perl-IO-Compress-1.0
	sci-biology/bioperl
	>=dev-perl/HTML-Parser-3
	>=dev-perl/libwww-perl-5
	>=virtual/perl-MIME-Base64-2.12"
RDEPEND="${DEPEND}"

SRC_TEST=online
