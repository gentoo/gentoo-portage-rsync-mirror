# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Schedule-At/Schedule-At-1.150.0.ebuild,v 1.3 2012/08/03 10:55:11 ago Exp $

EAPI=4

MODULE_AUTHOR=JOSERODR
MODULE_VERSION=1.15
inherit perl-module

DESCRIPTION="OS independent interface to the Unix 'at' command"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="sys-process/at"
DEPEND="${RDEPEND}"

#SRC_TEST="do"
