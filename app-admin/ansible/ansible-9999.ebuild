# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ansible/ansible-9999.ebuild,v 1.5 2013/01/05 13:39:27 pinkbyte Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )

EGIT_REPO_URI="git://github.com/ansible/ansible.git"
EGIT_BRANCH="devel"

inherit distutils-r1 git-2

DESCRIPTION="Radically simple deployment, model-driven configuration management, and command execution framework"
HOMEPAGE="http://ansible.cc/"
SRC_URI=""

KEYWORDS=""
LICENSE="GPL-3"
SLOT="0"
IUSE="examples paramiko +sudo test"

DEPEND="${PYTHON_DEPS}
	test? (
		dev-python/nose
		dev-vcs/git
	)"
RDEPEND="
	dev-python/jinja
	dev-python/pyyaml
	paramiko? ( dev-python/paramiko )
	!paramiko? ( virtual/ssh )
	sudo? ( app-admin/sudo )
"

src_prepare() {
	distutils-r1_src_prepare
	# Skip tests which need ssh access
	sed -i 's:PYTHONPATH=./lib nosetests.*:\0 -e \\(TestPlayBook.py\\|TestRunner.py\\):' Makefile || die "sed failed"
}

src_test() {
	make tests
}

src_install() {
	distutils-r1_src_install

	insinto /usr/share/ansible
	doins library/*

	doman docs/man/man1/*.1
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${P}/examples
	fi
	# Hint: do not install example config files into /etc
	# let this choice to user

	newenvd "${FILESDIR}"/${PN}.env 95ansible
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] ; then
		elog "You can define parameters through shell variables OR use config files"
		elog "Examples of config files installed in /usr/share/doc/${P}/examples"
		elog "You have to create ansible hosts file!"
		elog "More info on http://ansible.cc/docs/gettingstarted.html"
	fi
}
