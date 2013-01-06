# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/treetop/treetop-1.4.10.ebuild,v 1.6 2012/05/01 18:24:23 armin76 Exp $

EAPI=4
USE_RUBY="ruby18 ree18"
# jruby fails tests, not investigated yet.

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="none"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Treetop is a language for describing languages."
HOMEPAGE="http://treetop.rubyforge.org/"
LICENSE="Ruby"

KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~sparc-solaris ~x86-solaris"
SLOT="0"
IUSE=""

ruby_add_bdepend "test? ( >=dev-ruby/rr-0.10.2 dev-ruby/rspec:2 dev-ruby/activesupport )"
ruby_add_rdepend ">=dev-ruby/polyglot-0.3.1"

each_ruby_test() {
	${RUBY} -S rspec spec || die
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}/examples
	doins -r examples/*
}
