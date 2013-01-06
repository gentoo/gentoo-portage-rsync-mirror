# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Derivative/Math-Derivative-0.10.0.ebuild,v 1.2 2011/09/03 21:04:46 tove Exp $

EAPI=4

MODULE_AUTHOR=JARW
MODULE_VERSION=0.01
inherit perl-module

DESCRIPTION="1st and 2nd order differentiation of data"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# distribution without tests
SRC_TEST="no"
PATCHES=( "${FILESDIR}"/0.01-pod-1.diff )
