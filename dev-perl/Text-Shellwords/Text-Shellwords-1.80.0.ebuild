# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Shellwords/Text-Shellwords-1.80.0.ebuild,v 1.2 2011/09/03 21:04:49 tove Exp $

EAPI=4

MODULE_AUTHOR=LDS
MODULE_VERSION=1.08
inherit perl-module

DESCRIPTION="Parses lines of text and returns a set of tokens using the same rules as the Unix shell"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"
