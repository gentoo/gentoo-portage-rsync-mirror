# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Unload/Class-Unload-0.70.0-r1.ebuild,v 1.1 2014/08/26 16:07:29 axs Exp $

EAPI=5

MODULE_AUTHOR=ILMARI
MODULE_VERSION=0.07
inherit perl-module

DESCRIPTION="Unload a class"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Class-Inspector"
DEPEND="${RDEPEND}"

SRC_TEST=do
