# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-SAX-Base/XML-SAX-Base-1.80.0-r1.ebuild,v 1.1 2014/08/20 18:26:50 axs Exp $

EAPI=5

MODULE_AUTHOR=GRANTM
MODULE_VERSION=1.08
inherit perl-module eutils

DESCRIPTION="Base class SAX Drivers and Filters"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	!<dev-perl/XML-SAX-0.990.0
"
SRC_TEST="do"
