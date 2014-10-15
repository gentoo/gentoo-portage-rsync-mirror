# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/apparmor-utils/apparmor-utils-2.8.4.ebuild,v 1.1 2014/10/15 15:36:25 kensington Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} )

inherit perl-module python-r1 versionator

DESCRIPTION="Additional userspace utils to assist with AppArmor profile management"
HOMEPAGE="http://apparmor.net/"
SRC_URI="http://launchpad.net/apparmor/$(get_version_component_range 1-2)/${PV}/+download/apparmor-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/perl
	${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	~sys-libs/libapparmor-${PV}[perl]
	~sys-apps/apparmor-${PV}
	dev-perl/Locale-gettext
	dev-perl/RPC-XML
	dev-perl/TermReadKey
	virtual/perl-Data-Dumper
	virtual/perl-Getopt-Long"

S=${WORKDIR}/apparmor-${PV}/utils

src_compile() {
	python_export_best

	# launches non-make subprocesses causing "make jobserver unavailable"
	# error messages to appear in generated code
	emake -j1
}

src_install() {
	perlinfo
	emake DESTDIR="${D}" PERLDIR="${D}/${VENDOR_LIB}/Immunix" \
		VIM_INSTALL_PATH="${D}/usr/share/vim/vimfiles/syntax" install

	install_python() {
		"${PYTHON}" "${S}"/python-tools-setup.py install --prefix=/usr \
			--root="${D}" --version="${PV}"
	}

	python_foreach_impl install_python
	python_replicate_script "${D}"/usr/bin/aa-easyprof
}
