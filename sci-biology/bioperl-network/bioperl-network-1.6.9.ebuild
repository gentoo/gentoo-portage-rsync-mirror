# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bioperl-network/bioperl-network-1.6.9.ebuild,v 1.2 2014/08/09 22:48:22 zlogene Exp $

EAPI="5"

BIOPERL_RELEASE=1.6.9

MY_PN=BioPerl-Network
MODULE_AUTHOR=CJFIELDS
MODULE_VERSION=1.006900
inherit perl-module

DESCRIPTION="Perl tools for bioinformatics - Analysis of protein-protein interaction networks"
HOMEPAGE="http://www.bioperl.org/"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
SRC_TEST="do"

CDEPEND=">=sci-biology/bioperl-${PV}
	>=dev-perl/Graph-0.86"
DEPEND="virtual/perl-Module-Build
	${CDEPEND}"
RDEPEND="${CDEPEND}"

src_install() {
	mydoc="AUTHORS BUGS"
	perl-module_src_install
}
