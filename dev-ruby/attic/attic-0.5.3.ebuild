# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/attic/attic-0.5.3.ebuild,v 1.1 2013/12/25 07:07:28 graaff Exp $

EAPI=5

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem eutils

DESCRIPTION="A place for Ruby objects to hide instance variables"
HOMEPAGE="http://solutious.com/"

SRC_URI="https://github.com/delano/${PN}/archive/${PV}.tar.gz -> ${PN}-git-${PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

ruby_add_bdepend "test? (  dev-ruby/tryouts:2  )"

each_ruby_prepare() {
	case ${RUBY} in
		*ruby18)
			# Remove tests failing on ruby18 due to string/symbol
			# differences: https://github.com/delano/attic/issues/1
			rm try/01_mixins_tryouts.rb try/30_nometaclass_tryouts.rb || die
			;;
	esac
}

each_ruby_test() {
	${RUBY} -Ilib -S try || die "tests failed"
}
