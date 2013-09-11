# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/thread_safe/thread_safe-0.1.3.ebuild,v 1.1 2013/09/11 13:02:11 mrueg Exp $

EAPI=5
# jruby → there is code for this in ext but that requires compiling java.
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="A collection of thread-safe versions of common core Ruby classes"
HOMEPAGE="https://github.com/headius/thread_safe"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "dev-ruby/atomic"
