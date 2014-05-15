# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/priorityqueue/priorityqueue-0.1.2.ebuild,v 1.1 2014/05/15 02:00:33 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"
RUBY_FAKEGEM_NAME="PriorityQueue"

inherit multilib ruby-fakegem

DESCRIPTION="A fibonacci-heap priority-queue implementation"
HOMEPAGE="https://rubygems.org/gems/PriorityQueue"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

all_ruby_prepare() {
	rm Makefile *.o *.so || die
}

each_ruby_configure() {
	${RUBY} setup.rb config || die
}

each_ruby_compile() {
	${RUBY} setup.rb setup || die
	cp ext/priority_queue/*$(get_modname) lib/ || die
}

each_ruby_test() {
	${RUBY} -Ilib test/priority_queue_test.rb || die
}
