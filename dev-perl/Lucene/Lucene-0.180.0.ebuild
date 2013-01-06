# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lucene/Lucene-0.180.0.ebuild,v 1.1 2011/08/30 11:13:28 tove Exp $

EAPI=4

MODULE_AUTHOR=TBUSCH
MODULE_VERSION=0.18
inherit perl-module

DESCRIPTION="API to the C++ port of the Lucene search engine"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND="dev-cpp/clucene"
DEPEND="${RDEPEND}"

SRC_TEST="do"
