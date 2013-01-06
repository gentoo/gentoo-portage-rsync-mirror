# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Rcs/Rcs-1.50.0.ebuild,v 1.1 2011/08/29 09:43:40 tove Exp $

EAPI=4

MODULE_AUTHOR=CFRETER
MODULE_VERSION=1.05
inherit perl-module

DESCRIPTION="Perl bindings for Revision Control System"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-vcs/rcs"
DEPEND="${RDEPEND}"
