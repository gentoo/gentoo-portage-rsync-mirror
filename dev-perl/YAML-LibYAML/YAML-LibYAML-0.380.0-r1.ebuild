# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/YAML-LibYAML/YAML-LibYAML-0.380.0-r1.ebuild,v 1.1 2012/04/08 13:36:30 tove Exp $

EAPI=4
MODULE_AUTHOR=INGY
MODULE_VERSION=0.38
inherit perl-module

DESCRIPTION='Perl YAML Serialization using XS and libyaml'
SRC_URI+=" http://dev.gentoo.org/~tove/distfiles/dev-perl/${PN}-0.380.0-patches.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"
PATCHES=(
	"${WORKDIR}"/${PN}-patches/0.380.0-format_string_flaws.patch
)
export OPTIMIZE="$CFLAGS"
