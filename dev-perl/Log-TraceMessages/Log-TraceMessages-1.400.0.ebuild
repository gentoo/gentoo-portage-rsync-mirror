# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Log-TraceMessages/Log-TraceMessages-1.400.0.ebuild,v 1.2 2012/12/05 11:33:45 grobian Exp $

EAPI=4

MODULE_AUTHOR=EDAVIS
MODULE_VERSION=1.4
inherit perl-module

DESCRIPTION="Logging/debugging aid"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-linux"
IUSE=""

RDEPEND=">=dev-perl/HTML-FromText-1.004"
DEPEND="${RDEPEND}"

SRC_TEST="do"
