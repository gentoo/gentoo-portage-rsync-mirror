# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-GlobalDestruction/Devel-GlobalDestruction-0.70.0.ebuild,v 1.1 2012/07/27 19:10:01 tove Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.07
inherit perl-module

DESCRIPTION="Expose PL_dirty, the flag which marks global destruction"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x64-macos"
IUSE=""

RDEPEND="dev-perl/Sub-Exporter"
DEPEND="${RDEPEND}"

SRC_TEST=do
