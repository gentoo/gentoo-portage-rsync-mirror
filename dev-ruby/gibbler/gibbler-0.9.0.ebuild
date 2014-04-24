# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gibbler/gibbler-0.9.0.ebuild,v 1.2 2014/04/24 17:33:26 mrueg Exp $

EAPI=5

USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_EXTRAINSTALL="VERSION.yml"

inherit ruby-fakegem

DESCRIPTION="Git-like hashes for Ruby objects"
HOMEPAGE="http://solutious.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/attic-0.4.0"

ruby_add_bdepend "test? ( dev-ruby/tryouts:2 )"

SRC_URI="https://github.com/delano/${PN}/archive/v${PV}.tar.gz -> ${PN}-git-${PV}.tgz"

each_ruby_test() {
	${RUBY} -S try || die "tests failed"
}
