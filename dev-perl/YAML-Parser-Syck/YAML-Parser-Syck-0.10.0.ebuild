# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/YAML-Parser-Syck/YAML-Parser-Syck-0.10.0.ebuild,v 1.2 2011/09/03 21:04:53 tove Exp $

EAPI=4

MODULE_AUTHOR=INGY
MODULE_VERSION=0.01
inherit perl-module

DESCRIPTION="Perl Wrapper for the YAML Parser Extension: libsyck"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-libs/syck"
DEPEND="${RDEPEND}"

SRC_TEST="do"
