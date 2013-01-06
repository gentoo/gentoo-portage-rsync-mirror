# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/String-RewritePrefix/String-RewritePrefix-0.6.0.ebuild,v 1.1 2012/06/16 21:14:25 tove Exp $

EAPI="4"

MODULE_AUTHOR="RJBS"
MODULE_VERSION=0.006
inherit perl-module

DESCRIPTION="Rewrite strings based on a set of known prefixes"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/Sub-Exporter-0.982.0"
DEPEND="${RDEPEND}"

SRC_TEST="do"
