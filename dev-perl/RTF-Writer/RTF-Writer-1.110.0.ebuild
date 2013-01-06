# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RTF-Writer/RTF-Writer-1.110.0.ebuild,v 1.2 2011/09/03 21:05:17 tove Exp $

EAPI=4

MODULE_AUTHOR=SBURKE
MODULE_VERSION=1.11
inherit perl-module

DESCRIPTION="RTF::Writer - for generating documents in Rich Text Format"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="dev-perl/ImageSize"
DEPEND="${RDEPEND}"

SRC_TEST="do"
