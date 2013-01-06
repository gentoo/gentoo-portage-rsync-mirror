# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-ExuberantCTags/Parse-ExuberantCTags-1.20.0.ebuild,v 1.1 2011/08/29 10:55:48 tove Exp $

EAPI=4

MODULE_AUTHOR=SMUELLER
MODULE_VERSION=1.02
inherit perl-module

DESCRIPTION="Efficiently parse exuberant ctags files"

# contains readtags.c from ctags
LICENSE="${LICENSE} public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST=do
