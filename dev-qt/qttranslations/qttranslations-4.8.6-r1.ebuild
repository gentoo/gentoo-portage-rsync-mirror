# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qttranslations/qttranslations-4.8.6-r1.ebuild,v 1.1 2014/11/15 02:38:42 pesa Exp $

EAPI=5

inherit qt4-build-multilib

DESCRIPTION="Translation files for the Qt toolkit"

if [[ ${QT4_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
fi

IUSE=""

DEPEND="
	~dev-qt/qtcore-${PV}
"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="translations"

multilib_src_configure() {
	qt4_prepare_env
	qt4_symlink_tools_to_build_dir
	qt4_foreach_target_subdir qt4_qmake
}
