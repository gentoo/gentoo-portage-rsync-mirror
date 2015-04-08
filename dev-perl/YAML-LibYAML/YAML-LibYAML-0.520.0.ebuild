# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/YAML-LibYAML/YAML-LibYAML-0.520.0.ebuild,v 1.1 2014/10/27 20:41:25 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=INGY
MODULE_VERSION=0.52
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
