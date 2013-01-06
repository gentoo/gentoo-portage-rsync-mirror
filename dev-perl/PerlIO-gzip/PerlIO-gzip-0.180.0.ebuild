# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PerlIO-gzip/PerlIO-gzip-0.180.0.ebuild,v 1.2 2011/09/03 21:04:45 tove Exp $

EAPI=4

MODULE_AUTHOR=NWCLARK
MODULE_VERSION=0.18
inherit perl-module

DESCRIPTION="PerlIO::Gzip - PerlIO layer to gzip/gunzip"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

SRC_TEST="do"
