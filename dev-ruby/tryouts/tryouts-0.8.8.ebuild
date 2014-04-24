# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tryouts/tryouts-0.8.8.ebuild,v 1.6 2014/04/24 16:31:29 mrueg Exp $

EAPI=5

USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="High-level testing library (DSL) for Ruby codes and command-line applications"
HOMEPAGE="http://solutious.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT=test

ruby_add_rdepend 'dev-ruby/sysinfo
	dev-ruby/drydock
	dev-ruby/attic'

each_ruby_test() {
	${RUBY} -Ilib bin/sergeant || die "Tests failed"
}
