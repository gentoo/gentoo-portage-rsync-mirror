# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/attic/attic-0.5.3.ebuild,v 1.2 2014/04/24 17:36:36 mrueg Exp $

EAPI=5

USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="A place for Ruby objects to hide instance variables"
HOMEPAGE="http://solutious.com/"

SRC_URI="https://github.com/delano/${PN}/archive/${PV}.tar.gz -> ${PN}-git-${PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

ruby_add_bdepend "test? (  dev-ruby/tryouts:2  )"

each_ruby_test() {
	${RUBY} -Ilib -S try || die "tests failed"
}
