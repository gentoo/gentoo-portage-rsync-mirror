# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/linkchecker/linkchecker-8.3.ebuild,v 1.4 2013/01/31 12:59:35 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite?"

inherit bash-completion-r1 distutils-r1 eutils multilib

MY_P="${P/linkchecker/LinkChecker}"

DESCRIPTION="Check websites for broken links"
HOMEPAGE="http://wummel.github.com/linkchecker/ http://pypi.python.org/pypi/linkchecker/"
SRC_URI="mirror://github/downloads/wummel/${PN}/${MY_P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-macos ~x64-solaris"
IUSE="bash-completion clamav doc geoip gnome login nagios sqlite syntax-check X"

RDEPEND="
	dev-python/dnspython
	bash-completion? ( dev-python/optcomplete )
	clamav? ( app-antivirus/clamav )
	geoip? ( dev-python/geoip-python )
	gnome? ( dev-python/pygtk:2 )
	login? ( dev-python/twill )
	syntax-check? (
		dev-python/cssutils
		dev-python/utidylib
		)
	X? (
		|| (
			>=dev-python/PyQt4-4.9.6-r1[X,help]
			<dev-python/PyQt4-4.9.6-r1[X,assistant] )
		dev-python/qscintilla-python
		)"
DEPEND="
	doc? ( x11-libs/qt-assistant:4 )"

RESTRICT="test"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}"/8.0-missing-files.patch
		"${FILESDIR}"/${P}-unbundle.patch
		"${FILESDIR}"/${PN}-8.0-desktop.patch
		)
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C doc/html
}

python_install_all() {
	distutils-r1_python_install_all
	if ! use X; then
		delete_gui() {
				rm -rf \
					"${ED}"/usr/bin/linkchecker-gui* \
					"${ED}"/$(python_get_sitedir)/linkcheck/gui* || die
		}
		python_foreach_impl delete_gui
	fi
	use doc && dohtml doc/html/*
	use bash-completion && dobashcomp config/linkchecker-completion
	insinto /usr/$(get_libdir)/nagios/plugins
	if use nagios; then
		doins linkchecker-nagios
	else
		rm -f "${ED}"/usr/bin/linkchecker-nagios* || die
	fi
}
