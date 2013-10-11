# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ansible/ansible-1.3.3.ebuild,v 1.1 2013/10/11 11:30:57 pinkbyte Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 readme.gentoo

DESCRIPTION="Radically simple deployment, model-driven configuration management, and command execution framework"
HOMEPAGE="http://ansible.cc/"
SRC_URI="https://github.com/ansible/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="test"

DEPEND="test? (
		dev-python/nose
		dev-vcs/git
	)"
RDEPEND="
	dev-python/jinja
	dev-python/pyyaml
	dev-python/paramiko
	net-misc/sshpass
	virtual/ssh
"

DOC_CONTENTS="You can define parameters through shell variables OR use config files
Examples of config files installed in /usr/share/doc/${PF}/examples\n\n
You have to create ansible hosts file!\n
More info on http://ansible.cc/docs/gettingstarted.html"

python_prepare_all() {
	distutils-r1_python_prepare_all
	# Skip tests which need ssh access
	sed -i 's:$(NOSETESTS) -d -v:\0 -e \\(TestPlayBook.py\\|TestRunner.py\\):' Makefile || die "sed failed"
}

python_test() {
	make tests || die "tests failed"
}

python_install_all() {
	distutils-r1_python_install_all

	doman docs/man/man1/*.1
	dodoc -r examples
	docompress -x /usr/share/doc/${PF}/examples
	# Hint: do not install example config files into /etc
	# let this choice to user

	newenvd "${FILESDIR}"/${PN}.env 95ansible
}

src_install() {
	distutils-r1_src_install
	readme.gentoo_create_doc
}
