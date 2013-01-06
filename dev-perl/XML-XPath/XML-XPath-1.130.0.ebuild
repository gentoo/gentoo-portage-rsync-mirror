# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XPath/XML-XPath-1.130.0.ebuild,v 1.2 2011/09/03 21:05:25 tove Exp $

EAPI=4

MODULE_AUTHOR=MSERGEANT
MODULE_VERSION=1.13
inherit perl-module

DESCRIPTION="A XPath Perl Module"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=">=dev-perl/XML-Parser-2.30"
DEPEND="${RDEPEND}"
