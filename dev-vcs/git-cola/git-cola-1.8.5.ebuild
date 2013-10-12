# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/git-cola/git-cola-1.8.5.ebuild,v 1.2 2013/10/12 02:35:47 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
DISTUTILS_SINGLE_IMPL=true

inherit distutils-r1

DESCRIPTION="The highly caffeinated git GUI"
HOMEPAGE="http://git-cola.github.com/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

RDEPEND="
	dev-python/jsonpickle[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/PyQt4[${PYTHON_USEDEP}]
	dev-vcs/git"
DEPEND="${RDEPEND}
	app-text/asciidoc
	app-text/xmlto
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	sys-devel/gettext
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

PATCHES=(
	"${FILESDIR}"/1.3.8-disable-tests.patch
	"${FILESDIR}"/1.8.1-system-ssh-askpass.patch
	)

python_prepare_all() {
	# unfinished translate framework
	rm test/test_cola_i18n.py || die
	# don't install docs into wrong location
	sed -i \
		-e '/doc/d' \
		setup.py || die "sed failed"

	sed -i \
		-e  "s|'doc', 'git-cola'|'doc', '${PF}', 'html'|" \
		cola/resources.py || die "sed failed"

	distutils-r1_python_prepare_all
}

python_compile_all() {
	cd share/doc/${PN}/
	if use doc ; then
		emake all
	else
		sed \
			-e '/^install:/s:install-html::g' \
			-i Makefile || die
	fi
}

python_install_all() {
	cd share/doc/${PN}/ || die
	emake \
		DESTDIR="${D}" \
		docdir="${EPREFIX}/usr/share/doc/${PF}" \
		prefix="${EPREFIX}/usr" \
		install

	if use doc ; then
		HTML_DOCS=( share/doc/${PN}/_build/html/. )
	else
		HTML_DOCS=( "${FILESDIR}"/index.html )
	fi

	distutils-r1_python_install_all
}

python_test() {
	PYTHONPATH="${S}:${S}/build/lib:${PYTHONPATH}" LC_ALL="C" nosetests \
		--verbose --with-doctest --with-id --exclude=jsonpickle --exclude=json \
		|| die "running nosetests failed"
}

pkg_postinst() {
	elog "Please make sure you have either a SSH key management installed and activated or"
	elog "installed a SSH askpass app like net-misc/x11-ssh-askpass."
	elog "Otherwise ${PN} may hang when pushing/pulling from remote git repositories via SSH. "
}
