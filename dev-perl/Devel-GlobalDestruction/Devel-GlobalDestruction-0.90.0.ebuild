# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-GlobalDestruction/Devel-GlobalDestruction-0.90.0.ebuild,v 1.3 2012/09/17 16:43:15 grobian Exp $

EAPI=4

MODULE_AUTHOR=RIBASUSHI
MODULE_VERSION=0.09
inherit perl-module

DESCRIPTION="Expose PL_dirty, the flag which marks global destruction"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-aix ~x86-solaris"
IUSE=""

RDEPEND=">=dev-perl/Sub-Exporter-Progressive-0.1.2"
DEPEND="${RDEPEND}"

SRC_TEST=do
