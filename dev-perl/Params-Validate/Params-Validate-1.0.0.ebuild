# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Validate/Params-Validate-1.0.0.ebuild,v 1.9 2012/03/18 18:21:45 armin76 Exp $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=1.00
inherit perl-module

DESCRIPTION="A module to provide a flexible system for validation method/function call parameters"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-Attribute-Handlers"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.35"

SRC_TEST="do"
