# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AppConfig/AppConfig-1.660.0.ebuild,v 1.3 2012/09/01 11:12:19 grobian Exp $

EAPI=4

MODULE_AUTHOR=ABW
MODULE_VERSION=1.66
inherit perl-module eutils

DESCRIPTION="Perl5 module for reading configuration files and parsing command line arguments."

SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~ppc-aix ~x86-fbsd ~x86-solaris"
IUSE=""

DEPEND=">=dev-perl/File-HomeDir-0.57"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/blockdiffs.patch" )
SRC_TEST="do"
