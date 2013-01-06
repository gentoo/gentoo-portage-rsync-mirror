# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Element-Extended/HTML-Element-Extended-1.180.0.ebuild,v 1.10 2012/12/05 11:32:15 grobian Exp $

EAPI=4

MODULE_AUTHOR=MSISK
MODULE_VERSION=1.18
inherit perl-module

DESCRIPTION="Extension for manipulating a table composed of HTML::Element style components."

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc ppc64 x86 ~x86-linux"
IUSE=""

RDEPEND=">=dev-perl/HTML-Tree-3.01"
DEPEND="${RDEPEND}"

SRC_TEST="do"
